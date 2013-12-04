/*
 * CS250
 *
 * simple.l: simple parser for the simple "C" language
 *
 */

%token	<string_val> WORD

%token 	NOTOKEN LPARENT RPARENT LBRACE RBRACE LCURLY RCURLY COMA SEMICOLON EQUAL STRING_CONST LONG LONGSTAR VOID CHARSTAR CHARSTARSTAR INTEGER_CONST AMPERSAND OROR ANDAND EQUALEQUAL NOTEQUAL LESS GREAT LESSEQUAL GREATEQUAL PLUS MINUS TIMES DIVIDE PERCENT IF ELSE WHILE DO FOR CONTINUE BREAK RETURN

%union	{
		char   *string_val;
		int nargs;
		int my_nlabel;
	}

%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern int line_number;
const char * input_file;
char * asm_file;
FILE * fasm;

#define MAX_ARGS 5
int nargs = 0;
char * args_table[MAX_ARGS];

#define MAX_GLOBALS 100
int global_var_space = 0;
int nglobals = 0;
char * global_vars_table[MAX_GLOBALS];
int global_vars_type[MAX_GLOBALS];

#define MAX_LOCALS 16
int nlocals = 0;
char * local_vars_table[MAX_LOCALS];
int local_vars_type[MAX_LOCALS];

#define MAX_STRINGS 100
int nstrings = 0;
char * string_table[MAX_STRINGS];

char *regStk[]={ "rbx", "r10", "r13", "r14", "r15"};
char nregStk = sizeof(regStk)/sizeof(char*);

char *regArgs[]={ "rdi", "rsi", "rdx", "rcx", "r8", "r9"};
char nregArgs = sizeof(regArgs)/sizeof(char*);


int top = 0;
 
int nlabel = 0;

int var_space = 8;

int curr_type;

int nearest_loop_end;

int function_return_n = 0;

int flag;

void addGlobalVar(char *id, int type) {
	global_vars_table[nglobals] = id;
	global_vars_type[nglobals] = type;
	nglobals ++;
}

void addLocalVar(char * id, int type) {
	local_vars_table[nlocals] = id;
	local_vars_type[nlocals] = type;
	nlocals ++;	
}

int lookupGlobalVar(char * id) {
	int i;
	for (i = 0; i < nglobals; i ++) {
		if (!strcmp(global_vars_table[i], id)) {
			return i;
		}
	}
	return -1;
}

int lookupLocalVar(char * id) {
	int i;
	for (i = 0; i < nlocals; i ++) {
		if (!strcmp(local_vars_table[i], id)) {
			return i;
		}
	}
	return -1;	
}

int lookupLocalVarType(char * id) {
	int i;
	for (i = 0; i < nlocals; i ++) {
		if (!strcmp(local_vars_table[i], id)) {
			return local_vars_type[i];
		}
	}
	printf("wooo\n");
	return -1;	
}

int lookupGlobalVarType(char * id) {
	int i;
	for (i = 0; i < nglobals; i ++) {
		if (!strcmp(global_vars_table[i], id)) {
			return global_vars_type[i];
		}
	}
	printf("wooo\n");
	return -1;	
}


%}

%%

goal:	program
	;

program :
        function_or_var_list;

function_or_var_list:
        function_or_var_list function
        | function_or_var_list global_var
        | /*empty */
	;

function:
         var_type WORD
         {
         function_return_n ++;
		 fprintf(fasm, ".text\n");
		 fprintf(fasm, ".global %s\n", $2);

		 fprintf(fasm, "%s:\n", $2);

		 fprintf(fasm, "# Save registers\n");
		 fprintf(fasm, "\tpushq %%rbx\n");
		 fprintf(fasm, "\tpushq %%r10\n");
		 fprintf(fasm, "\tpushq %%r13\n");
		 fprintf(fasm, "\tpushq %%r14\n");
		 fprintf(fasm, "\tpushq %%r15\n");
		 fprintf(fasm, "\tsubq $%d, %%rsp\n", 8*MAX_LOCALS);			 
	 }
	 LPARENT arguments RPARENT 
	 {
	 	 int i;
	 	 fprintf(fasm, "\t#Save arguments\n");
	 	 for (i = 0; i < nargs; i ++) {
	 	 	fprintf(fasm, "\tmovq %%%s, %d(%%rsp)\n", regArgs[i], 8*(MAX_LOCALS-i));
	 	 }
	 	 nargs = 0;
	 }
	 compound_statement
  	 {
  	 	fprintf(fasm, "function_return_%d:", function_return_n);		 	
     	fprintf(fasm, "\taddq $%d, %%rsp\n", 8*MAX_LOCALS);		 	
     	fprintf(fasm, "# Restore registers\n");
		fprintf(fasm, "\tpopq %%r15\n");
		fprintf(fasm, "\tpopq %%r14\n");
		fprintf(fasm, "\tpopq %%r13\n");
		fprintf(fasm, "\tpopq %%r10\n");
		fprintf(fasm, "\tpopq %%rbx\n");
		fprintf(fasm, "\tret\n", $2);
		nlocals = 0;		
     }
	;

arg_list:
         arg 
         | arg_list COMA arg
	 ;

arguments:
         arg_list
	 | /*empty*/
	 ;

arg: var_type WORD {
	addLocalVar($<string_val>2, curr_type);
	nargs ++;
};

global_var: 
    var_type global_var_list SEMICOLON ;

global_var_list: 
	WORD {
		fprintf(fasm, "# Reserve space\n");
		fprintf(fasm, ".data\n");
		fprintf(fasm, "\t.comm\t%s, %d\n", $<string_val>1, var_space);
		// add to table
		addGlobalVar($<string_val>1, curr_type);
    }
	| global_var_list COMA WORD {
		fprintf(fasm, "# Reserve space\n");
		fprintf(fasm, ".data\n");
		fprintf(fasm, "\t.comm\t%s, %d\n", $<string_val>3, var_space);
		// add to table 	
		addGlobalVar($<string_val>3, curr_type);	
	};

var_type: 
	CHARSTAR {curr_type = 0;}
	| CHARSTARSTAR {curr_type = 1;}
	| LONG {curr_type = 2;}
	| LONGSTAR {curr_type = 3;}
	| VOID {curr_type = 4;};

assignment:
    WORD EQUAL expression {
    	// find variable 
    	char * id = $<string_val>1;
    	int i = lookupLocalVar(id);

    	if (i >= 0) {
    		fprintf(fasm, "\t#Assign to Local var %s\n", id);
    		fprintf(fasm, "\tmovq %%%s, %d(%%rsp)\n", regStk[top-1], 8*(MAX_LOCALS-i));
    	}
    	else {
    		fprintf(fasm, "\t#Assign to Global var %s\n", id);
    		fprintf(fasm, "\tmovq %%%s, %s(%%rip)\n", regStk[top-1], $<string_val>1);
    	}
    	top --;
    }
	| WORD LBRACE expression RBRACE {
		char * id = $<string_val>1;
    	int i = lookupLocalVar(id);
    	flag = 0;
    	if (i >= 0) {
    		fprintf(fasm, "\t#Assign to Local var %s\n", id);
    		fprintf(fasm, "\tmovq %d(%%rsp), %%rbp\n", 8*(MAX_LOCALS-i));
    		if (lookupLocalVarType(id) <= 0) {
    			fprintf(fasm, "\timulq $1, %%%s\n", regStk[top-1]);
    			flag = 1;
    		}
    		else
    			fprintf(fasm, "\timulq $8, %%%s\n", regStk[top-1]);
    		fprintf(fasm, "\taddq %%%s, %%rbp\n", regStk[top-1]);
    	}
    	else {
    		fprintf(fasm, "\t#Assign to Global var %s\n", id);
    		fprintf(fasm, "\tmovq %s(%%rip), %%rbp\n", $<string_val>1);\
    		if (lookupGlobalVarType(id) <= 0) {
    			fprintf(fasm, "\timulq $1, %%%s\n", regStk[top-1]);
    			flag = 1;
    		}
    		else
    			fprintf(fasm, "\timulq $8, %%%s\n", regStk[top-1]);
    		fprintf(fasm, "\taddq %%%s, %%rbp\n", regStk[top-1]);
    	}
    	top --;		
	 } EQUAL expression {
	 	if (flag == 1) {
	 		fprintf(fasm, "\tmovq %%%s, %%rcx\n", regStk[top-1]);
	 		fprintf(fasm, "\tmovb %%cl, (%%rbp)\n");
	 	}
	 	else
	 		fprintf(fasm, "\tmovq %%%s, (%%rbp)\n", regStk[top-1]);
	 	top--;
	 }
	;

call :
         WORD LPARENT  call_arguments RPARENT {
		 char * funcName = $<string_val>1;
		 int nargs = $<nargs>3;
		 int i;
		 fprintf(fasm,"     # func=%s nargs=%d\n", funcName, nargs);
     		 fprintf(fasm,"     # Move values from reg stack to reg args\n");
		 for (i=nargs-1; i>=0; i--) {
			top--;
			fprintf(fasm, "\tmovq %%%s, %%%s\n",
			  regStk[top], regArgs[i]);
		 }
		 if (!strcmp(funcName, "printf")) {
			 // printf has a variable number of arguments
			 // and it need the following
			 fprintf(fasm, "\tmovl $0, %%eax\n");
		 }
		 fprintf(fasm, "\tcall %s\n", funcName);
		 fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top]);
		 top++;
         }
      ;

call_arg_list:
         expression {
		$<nargs>$=1;
	 }
         | call_arg_list COMA expression {
		$<nargs>$++;
	 }

	 ;

call_arguments:
         call_arg_list { $<nargs>$=$<nargs>1; }
	 | /*empty*/ { $<nargs>$=0;}
	 ;

expression :
         logical_or_expr
	 ;

logical_or_expr:
         logical_and_expr
	 | logical_or_expr OROR logical_and_expr {
	 	fprintf(fasm,"\n\t# ||\n");
		if (top<nregStk) {
			fprintf(fasm, "\torq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
	 }
	 ;

logical_and_expr:
         equality_expr
	 | logical_and_expr ANDAND equality_expr {
	 	fprintf(fasm,"\n\t# &&\n");
		if (top<nregStk) {
			fprintf(fasm, "\tandq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
	 }
	 ;

equality_expr:
         relational_expr
	 | equality_expr EQUALEQUAL relational_expr {
	 	fprintf(fasm,"\n\t# less\n");
		if (top<nregStk) {
			fprintf(fasm, "\tcmpq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rax\n");
			fprintf(fasm, "\tsete %%al\n");
			top --;
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-1]);
		}
	 }
	 | equality_expr NOTEQUAL relational_expr {
	 	fprintf(fasm,"\n\t# less\n");
		if (top<nregStk) {
			fprintf(fasm, "\tcmpq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rax\n");
			fprintf(fasm, "\tsetne %%al\n");
			top --;
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-1]);
		}
	 }
	 ;

relational_expr:
         additive_expr
	 | relational_expr LESS additive_expr {
	 	fprintf(fasm,"\n\t# less\n");
		if (top<nregStk) {
			fprintf(fasm, "\tcmpq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rax\n");
			fprintf(fasm, "\tsetl %%al\n");
			top --;
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-1]);
		}
	 }
	 | relational_expr GREAT additive_expr {
	 	fprintf(fasm,"\n\t# greater\n");
		if (top<nregStk) {
			fprintf(fasm, "\tcmpq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rax\n");
			fprintf(fasm, "\tsetg %%al\n");
			top --;
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-1]);
		}
	 }
	 | relational_expr LESSEQUAL additive_expr {
	 	fprintf(fasm,"\n\t# less\n");
		if (top<nregStk) {
			fprintf(fasm, "\tcmpq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rax\n");
			fprintf(fasm, "\tsetle %%al\n");
			top --;
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-1]);
		}
	 }
	 | relational_expr GREATEQUAL additive_expr {
	 	fprintf(fasm,"\n\t# less\n");
		if (top<nregStk) {
			fprintf(fasm, "\tcmpq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rax\n");
			fprintf(fasm, "\tsetge %%al\n");
			top --;
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-1]);
		}
	 }
	 ;

additive_expr:
          multiplicative_expr
	  | additive_expr PLUS multiplicative_expr {
		fprintf(fasm,"\n\t# +\n");
		if (top<nregStk) {
			fprintf(fasm, "\taddq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
	  }
	  | additive_expr MINUS multiplicative_expr {
	  	fprintf(fasm,"\n\t# -\n");
		if (top<nregStk) {
			fprintf(fasm, "\tsubq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
	  }
	  ;

multiplicative_expr:
          primary_expr
	  | multiplicative_expr TIMES primary_expr {
		fprintf(fasm,"\n\t# *\n");
		if (top<nregStk) {
			fprintf(fasm, "\timulq %%%s,%%%s\n", 
				regStk[top-1], regStk[top-2]);
			top--;
		}
      }
	  | multiplicative_expr DIVIDE primary_expr {
	  	fprintf(fasm,"\n\t# /\n");
		if (top<nregStk) {
			fprintf(fasm, "\tmovq %%%s, %%rax\n", regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rdx\n");
			fprintf(fasm, "\tidivq %%%s\n", regStk[top-1]);
			fprintf(fasm, "\tmovq %%rax, %%%s\n", regStk[top-2]);
			top --;
		}
	  }
	  | multiplicative_expr PERCENT primary_expr {
	  	fprintf(fasm,"\n\t# %%\n");
		if (top<nregStk) {	
			fprintf(fasm, "\tmovq %%%s, %%rax\n", regStk[top-2]);
			fprintf(fasm, "\tmovq $0, %%rdx\n");
			fprintf(fasm, "\tidivq %%%s\n", regStk[top-1]);
			fprintf(fasm, "\tmovq %%rdx, %%%s\n", regStk[top-2]);
			top --;
		}
	  }
	  ;

primary_expr:
	  STRING_CONST {
		  // Add string to string table.
		  // String table will be produced later
		  string_table[nstrings]=$<string_val>1;
		  fprintf(fasm, "\t#top=%d\n", top);
		  fprintf(fasm, "\n\t# push string %s top=%d\n",
			  $<string_val>1, top);
		  if (top<nregStk) {
		  	fprintf(fasm, "\tmovq $string%d, %%%s\n", 
				nstrings, regStk[top]);
			//fprintf(fasm, "\tmovq $%s,%%%s\n", 
				//$<string_val>1, regStk[top]); 
			top++;
		  }
		  nstrings++;
	  }
      | call
	  | WORD {
		char * id = $<string_val>1;
   	  	int i = lookupLocalVar(id);

		if (i >= 0) {
			fprintf(fasm, "\tmovq %d(%%rsp), %%%s\n", 8*(MAX_LOCALS-i), regStk[top]);
		}
		else {
		  fprintf(fasm, "\tmovq %s(%%rip),%%%s\n", id, regStk[top]);
		}
		top++;
	  }
	  | WORD LBRACE expression RBRACE {
	  	char * id = $<string_val>1;
    	int i = lookupLocalVar(id);

    	if (i >= 0) {
    		fprintf(fasm, "\t#Obtain Local var %s\n", id);
    		fprintf(fasm, "\tmovq %d(%%rsp), %%rax\n", 8*(MAX_LOCALS-i));
    		if (lookupLocalVarType(id) <= 0) {
    			fprintf(fasm, "\timulq $1, %%%s\n", regStk[top-1]);
    			fprintf(fasm, "\taddq %%%s, %%rax\n", regStk[top-1]);
    			fprintf(fasm, "\tmovb (%%rax), %%cl\n");    			
    			fprintf(fasm, "\tmovq %%rcx, %%%s\n", regStk[top-1]);
    		}
    		else {
    			fprintf(fasm, "\timulq $8, %%%s\n", regStk[top-1]);
    			fprintf(fasm, "\taddq %%%s, %%rax\n", regStk[top-1]);
    			fprintf(fasm, "\tmovq (%%rax), %%%s\n", regStk[top-1]);
    		}
    	}
    	else {
    		fprintf(fasm, "\t#Obtain Global var %s\n", id);
    		fprintf(fasm, "\tmovq %s(%%rip), %%rax\n", $<string_val>1);
    		if (lookupGlobalVarType(id) <= 0) {
    			fprintf(fasm, "\timulq $1, %%%s\n", regStk[top-1]);
    			fprintf(fasm, "\taddq %%%s, %%rax\n", regStk[top-1]);
    			fprintf(fasm, "\tmovb (%%rax), %%cl\n");    			
    			fprintf(fasm, "\tmovq %%rcx, %%%s\n", regStk[top-1]);
    		}
    		else {
    			fprintf(fasm, "\timulq $8, %%%s\n", regStk[top-1]);
    			fprintf(fasm, "\taddq %%%s, %%rax\n", regStk[top-1]);
    			fprintf(fasm, "\tmovq (%%rax), %%%s\n", regStk[top-1]);
    		}
    	}
	  }
	  | AMPERSAND WORD {
	  	char * id = $<string_val>2;
   	  	int i = lookupLocalVar(id);

		if (i >= 0) {
			fprintf(fasm, "\tleaq %d(%%rsp), %%%s\n", 8*(MAX_LOCALS-i), regStk[top]);
		}
		else {
		  fprintf(fasm, "\tleaq %s(%%rip),%%%s\n", id, regStk[top]);
		}
		top++;
	  }
	  | INTEGER_CONST {
		  fprintf(fasm, "\n\t# push %s\n", $<string_val>1);
		  if (top<nregStk) {
			fprintf(fasm, "\tmovq $%s,%%%s\n", 
				$<string_val>1, regStk[top]);
			top++;
		  }
	  }
	  | LPARENT expression RPARENT
	  ;

compound_statement:
	 LCURLY statement_list RCURLY
	 ;

statement_list:
         statement_list statement
	 | /*empty*/
	 ;

local_var:
        var_type local_var_list SEMICOLON;

local_var_list: 
		WORD
	 	{	
	 		addLocalVar($<string_val>1, curr_type);
		}
     | local_var_list COMA WORD
     	{
     		addLocalVar($<string_val>3, curr_type);
    	};

statement:
         assignment SEMICOLON
	 | call SEMICOLON {top = 0;}
	 | local_var
	 | compound_statement
	 | IF LPARENT {
		 	$<my_nlabel>1=nlabel;
			nlabel++;
			fprintf(fasm, "if_start_%d:\n", $<my_nlabel>1);
	 	} 
	 	expression RPARENT {
		 	fprintf(fasm, "\tcmpq $0, %%rbx\n");
			fprintf(fasm, "\tje if_else_%d\n", $<my_nlabel>1);
			top--;
	 	} 
	 	statement {
	 		fprintf(fasm, "\tjmp if_end_%d\n", $<my_nlabel>1);
	 		fprintf(fasm, "if_else_%d:\n", $<my_nlabel>1);
	 	} 
	 	else_optional {
	 		fprintf(fasm, "if_end_%d:\n", $<my_nlabel>1);
	 	}
	 | WHILE LPARENT {
		// act 1
		$<my_nlabel>1=nlabel;
		nearest_loop_end = nlabel;
		nlabel++;
		fprintf(fasm, "while_start_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "continue_start_%d: \n", $<my_nlabel>1);
         }
         expression RPARENT {
		// act2
		fprintf(fasm, "\tcmpq $0, %%rbx\n");
		fprintf(fasm, "\tje while_end_%d\n", $<my_nlabel>1);
		top--;
         }
         statement {
		// act3
		fprintf(fasm, "\tjmp while_start_%d\n", $<my_nlabel>1);
		fprintf(fasm, "while_end_%d:\n", $<my_nlabel>1);
		fprintf(fasm, "break_end_%d: \n", $<my_nlabel>1);
	 }
	 | DO {
	 		$<my_nlabel>1=nlabel;
	 		nearest_loop_end = nlabel;
			nlabel++;
	 		fprintf(fasm, "do_while_start_%d:\n", $<my_nlabel>1);
	 	}statement WHILE LPARENT {
	 		fprintf(fasm, "continue_start_%d: \n", $<my_nlabel>1);
	 	} expression RPARENT {
	 		fprintf(fasm, "\tcmpq $0, %%rbx\n");
			fprintf(fasm, "\tje do_while_end_%d\n", $<my_nlabel>1);
			fprintf(fasm, "\tjmp do_while_start_%d\n", $<my_nlabel>1);
			fprintf(fasm, "do_while_end_%d:\n", $<my_nlabel>1);
			fprintf(fasm, "break_end_%d: \n", $<my_nlabel>1);
			top--;	
	 	} SEMICOLON
	 | FOR LPARENT assignment {
	 	    $<my_nlabel>1=nlabel;
	 	    nearest_loop_end = nlabel;
			nlabel++;
			fprintf(fasm, "for_start_%d:\n", $<my_nlabel>1);
	 	} SEMICOLON expression {
	 		fprintf(fasm, "\tcmpq $0, %%rbx\n");
			fprintf(fasm, "\tje for_end_%d\n", $<my_nlabel>1);
			fprintf(fasm, "\tjmp for_statement_%d\n", $<my_nlabel>1);
			top--;
	 	} SEMICOLON {
	 		fprintf(fasm, "for_increment_%d: \n", $<my_nlabel>1);
	 		fprintf(fasm, "continue_start_%d: \n", $<my_nlabel>1);
	 	} assignment RPARENT {
	 		fprintf(fasm, "\tjmp for_start_%d\n", $<my_nlabel>1);
	 		fprintf(fasm, "for_statement_%d: \n", $<my_nlabel>1);
	   	} statement {
	   		fprintf(fasm, "\tjmp for_increment_%d\n", $<my_nlabel>1);
	   		fprintf(fasm, "for_end_%d: \n", $<my_nlabel>1);
	   		fprintf(fasm, "break_end_%d: \n", $<my_nlabel>1);	   		
	   	}
	 | jump_statement
	 ;

else_optional:
         ELSE  statement
	 | /* empty */
         ;

jump_statement:
         CONTINUE SEMICOLON {
         	fprintf(fasm, "\tjmp continue_start_%d\n", nearest_loop_end);
         }
	 | BREAK SEMICOLON {
	 		fprintf(fasm, "\tjmp break_end_%d\n", nearest_loop_end);
	 }
	 | RETURN expression SEMICOLON {
		 fprintf(fasm, "\tmovq %%rbx, %%rax\n");
		 fprintf(fasm, "\tjmp function_return_%d\n", function_return_n);
		 top = 0;
	 }
	 ;

%%

void yyset_in (FILE *  in_str );

int
yyerror(const char * s)
{
	fprintf(stderr,"%s:%d: %s\n", input_file, line_number, s);
}

int
main(int argc, char **argv)
{
	// Make sure there are enough arguments
	if (argc <2) {
		fprintf(stderr, "Usage: simple file\n");
		exit(1);
	}

	// Get file name
	input_file = strdup(argv[1]);

	int len = strlen(input_file);
	if (len < 2 || input_file[len-2]!='.' || input_file[len-1]!='c') {
		fprintf(stderr, "Error: file extension is not .c\n");
		exit(1);
	}

	// Get assembly file name
	asm_file = strdup(input_file);
	asm_file[len-1]='s';

	// Open file to compile
	FILE * f = fopen(input_file, "r");
	if (f==NULL) {
		fprintf(stderr, "Cannot open file %s\n", input_file);
		perror("fopen");
		exit(1);
	}

	// Create assembly file
	fasm = fopen(asm_file, "w");
	if (fasm==NULL) {
		fprintf(stderr, "Cannot open file %s\n", asm_file);
		perror("fopen");
		exit(1);
	}

	// Uncomment for debugging
	//fasm = stderr;

	// Create compilation file
	// 
	yyset_in(f);
	yyparse();

	// Generate string table
	int i;
	for (i = 0; i<nstrings; i++) {
		fprintf(fasm, "string%d:\n", i);
		fprintf(fasm, "\t.string %s\n\n", string_table[i]);
	}

	fclose(f);
	fclose(fasm);

	return 0;
}

