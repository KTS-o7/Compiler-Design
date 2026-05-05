BUILD_DIR ?= build
CC ?= gcc
LEX ?= flex
YACC ?= yacc
UNAME_S := $(shell uname -s)
ifeq ($(UNAME_S),Darwin)
LEX_LIB ?= -ll
else
LEX_LIB ?= -lfl
endif

LEX_SRC ?= Prog1/Lex/lex.l
YACC_SRC ?= Prog2/Yacc/yacc.y
YACC_LEX_SRC ?= Prog2/Yacc/lex.l

.PHONY: check-tools versions build-dir lex yacc clean

check-tools:
	@command -v $(CC) >/dev/null
	@command -v $(LEX) >/dev/null
	@command -v $(YACC) >/dev/null

versions:
	@$(CC) --version | head -n 1
	@$(LEX) --version
	@$(YACC) --version || true

build-dir:
	@mkdir -p "$(BUILD_DIR)"

lex: build-dir
	$(LEX) -o "$(BUILD_DIR)/lex.yy.c" "$(LEX_SRC)"
	$(CC) "$(BUILD_DIR)/lex.yy.c" $(LEX_LIB) -o "$(BUILD_DIR)/lex_runner"

yacc: build-dir
	$(YACC) -d -o "$(BUILD_DIR)/y.tab.c" "$(YACC_SRC)"
	$(LEX) -o "$(BUILD_DIR)/lex.yy.c" "$(YACC_LEX_SRC)"
	$(CC) "$(BUILD_DIR)/lex.yy.c" "$(BUILD_DIR)/y.tab.c" $(LEX_LIB) -o "$(BUILD_DIR)/parser_runner"

clean:
	rm -rf "$(BUILD_DIR)"
