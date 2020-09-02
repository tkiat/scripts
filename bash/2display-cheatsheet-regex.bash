#!/usr/bin/env bash
echo '
Flag
	g (global), i (case-insensitive), m (multiline), s (dotall), u (unicode), y (sticky)
Character
	Literal character
	\d, \w (A-Za-z0-0_), \s (\r\n\t\f)
	\D, \W, \S
	.
Position
	^, $, \b, \B
Quantifier
	*(>=0), +(>=1), ?(0 or 1), \d{3} (=3), \d{3,} (>=3)
	Lazy quantifier \d{3,5}? (stop at shortest match)
Operator
	aa|bb (or)
Character class
	[aeiou] (any one character in square brackets)
	[^aeiou] (anything not in aeiou)
	[a-f] (range)
Group
	(abc){3}, (ab+) (capturing group)
	([0-9]+)(?:st|nd|rd|th)? => non-capturing group: match but not capture it in result
	(?>foo|foot)s (atomic group: throw away alternative if 1st choice matched)
	a(?=b) => positive lookahead
	a(?!b) => negative lookahead
	(?<=b)a => positive lookbehind
	(?<!b)a => negative lookbehind
'
