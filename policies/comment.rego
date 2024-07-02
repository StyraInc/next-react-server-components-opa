package process.comment

import rego.v1

replacements := {"text"}

output[x] := y if {
	some x, y in input
	not x in replacements
}

# shorten comments
output["text"] := trim_maybe(short, trimmed) if {
	input.type == "comment"
	no_html := strings.replace_n({"<": "&lt;", ">": "&gt;"}, input.text)
	[short, trimmed] := max_len(no_html, 100)
}

else := input.text

trim_maybe(str, f) := sprintf("%s [...]", [str]) if f

else := str

max_len(str, k) := [last, trimmed] if {
	ps := split(str, " ")
	prefixes := [prefix |
		some i in numbers.range(1, count(ps))
		prefix := concat(" ", array.slice(ps, 0, i))
		count(prefix) <= k
	]
	last := prefixes[count(prefixes) - 1]
	trimmed := count(last) != count(str)
}
