package process.comment

import rego.v1

replacements := {}

karma := data.live.user(input.user).karma

output[x] := y if {
	some x, y in input
	not x in replacements
}

# if true, the comment will be collapsed on first view (can be expanded)
output["initToggled"] if karma < 1000

output["userKarma"] := karma
