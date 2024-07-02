package process.comment

import rego.v1

replacements := {"text"}

output[x] := y if {
	some x, y in input
	not x in replacements
}

output["by"] := input.by

output["id"] := input.id

output["parent"] := input.parent

output["time"] := input.time

output["type"] := input.type

# shorten comments
output["text"] := sprintf("%s [...]", [short]) if {
	input.type == "comment"
	no_html := strings.replace_n({"<": "&lt;", ">": "&gt;"}, input.text)
	short := max_len(no_html, 100)
}

else := input.text

max_len(str, k) := last if {
	ps := split(str, " ")
	prefixes := [prefix |
		some i in numbers.range(1, count(ps))
		prefix := concat(" ", array.slice(ps, 0, i))
		count(prefix) <= k
	]
	last := prefixes[count(prefixes) - 1]
}
