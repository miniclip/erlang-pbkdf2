SHELL := bash
.ONESHELL:
.SHELLFLAGS := -euc
.DELETE_ON_ERROR:
MAKEFLAGS += --warn-undefined-variables
MAKEFLAGS += --no-builtin-rules

version: upgrade clean compile check test edoc
.PHONY: version

upgrade: upgrade-rebar3_lint upgrade-eqc_rebar upgrade-rebar3_hex upgrade-rebar3_hank
	@rebar3 do unlock,upgrade
.PHONY: upgrade

upgrade-rebar3_lint:
	@rebar3 plugins upgrade rebar3_lint
.PHONY: upgrade-rebar3_lint

upgrade-eqc_rebar:
	@rebar3 plugins upgrade eqc_rebar
.PHONY: upgrade-eqc_rebar

upgrade-rebar3_hex:
	@rebar3 plugins upgrade rebar3_hex
.PHONY: upgrade-rebar3_hex

upgrade-rebar3_hank:
	@rebar3 plugins upgrade rebar3_hank
.PHONY: upgrade-rebar3_hank

clean:
	@rebar3 clean -a
.PHONY: clean

compile:
	@rebar3 compile
.PHONY: compile

check: xref dialyzer elvis-rock hank
.PHONY: check

xref:
	@rebar3 as test xref
.PHONY: xref

dialyzer:
	@rebar3 as test dialyzer
.PHONY: dialyzer

elvis-rock:
	@rebar3 lint
.PHONY: elvis-rock

hank:
	@rebar3 hank
.PHONY: hank

test:
.NOTPARALLEL: test
.PHONY: test

edoc:
	@rebar3 edoc
.PHONY: edoc
