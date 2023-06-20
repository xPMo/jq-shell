#!/usr/bin/env jq
module {
	"name": "shell"
};

def _sh_ident(pfx):
	pfx + gsub("[^0-9a-zA-Z]"; "");

def param(pfx):

	if type == "object" then
		[ to_entries[] |
		if (.value | type) == "object" then
			"typeset -A \(.key | _sh_ident(pfx))=(\(.value |
				[to_entries[] | "[\(.key | @sh?)]=\(.value | @sh?)"] | join(" ")
			))"

		elif (.value | type) == "array" then
			"typeset -a \(.key | _sh_ident(pfx))=(\(.value |
				[.[] | @sh] | join(" ")
			))"

		elif (.value | type) == "null" then
			empty

		elif (.value | type) == "number" then
			if .value == (.value | floor) then
				"typeset -i \(.key | _sh_ident(pfx))=\(.value)"
			else
				"[[ -v ZSH_ARGZERO ]] && typeset -F \(.key | _sh_ident(pfx))=\(.value)"
			end

		else
			"typeset \(.key | _sh_ident(pfx))=\(.value | @sh)"

		end
		] | join("\n")

	elif type == "array" then
		"set -- \(.[] | @sh)"

	else
		empty

	end;

def param: param("_");
