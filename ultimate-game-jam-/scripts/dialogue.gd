extends Node

var is_day_over = false 

var dialogue_tree = {
	# DAY 1
	"day1_start": {
		"dahlia_says": "hey!! guess what, i finally finished that project!",
		"opt1": "omg finally!! we should celebrate.",
		"opt2": "took u long enough lol",
		"next1": "day1_seb_intro_1",
		"next2": "day1_seb_intro_2"
	},
	"day1_seb_intro_1": {
		"dahlia_says": "totally!! oh, also this guy from my lab, Sebastian, invited a few of us for drinks later. might go for a bit?",
		"opt1": "i have a bit a headache :(",
		"opt2": "ohh sounds fun !",
		"next1": "day1_end",
		"next2": "day1_end_2"
	},
	"day1_seb_intro_2": {
		"dahlia_says": "hey! it was hard!! anyway, Sebastian (the guy from my lab) said he'd help me celebrate with the group later.",
		"opt1": "i have a bit a headache :(",
		"opt2": "ohh sounds fun !",
		"next1": "day1_end",
		"next2": "day1_end_2"
	},
	"day1_end": {
		"dahlia_says": "bummerrr, well i gtg, Sebas’ outside. talk tomorrow? <3",
		"opt1": "okk, have fun xx",
		"opt2": "ok bye dahli! love ya <3",
		"is_end_of_day": true,
		"next_day": 2,
		"quote": "Small beginnings lead to great heights.",
		"next_node": "day2_start"
	},
		"day1_end_2": {
		"dahlia_says": "yeahh well i gtg, Sebas’ outside. talk tomorrow? <3",
		"opt1": "okk, have fun xx",
		"opt2": "ok bye dahli! love ya <3",
		"is_end_of_day": true,
		"next_day": 2,
		"quote": "Small beginnings lead to great heights.",
		"next_node": "day2_start"
	},

	# DAY 2
	"day2_start": {
		"dahlia_says": "hey. sorry i'm late, was just out grabbing coffee.",
		"opt1": "it’s fine. how was your day?",
		"opt2": "with sebastian again?",
		"next1": "day2_branch_1",
		"next2": "day2_branch_2"
	},
	"day2_branch_1": {
		"dahlia_says": "it was okay. just tired. Sebastian and I studied for like 6 hours straight. he’s actually really funny.",
		"opt1": "oh, interesting",
		"opt2": "he wants something more dahlia.",
		"next1": "day2_confront",
		"next2": "day2_confront"
	},
	"day2_branch_2": {
		"dahlia_says": "wow... yeah, actually. he's just being a good friend because he knows I'm stressed. dont be like that.",
		"opt1": "oh, interesting",
		"opt2": "he wants something more dahlia",
		"next1": "day2_confront",
		"next2": "day2_confront"
	},
	"day2_confront": {
		"dahlia_says": "what do you mean?",
		"opt1": "i feel like we dont talk about anything except him lately.",
		"opt2": "i just miss how things were before he came along.",
		"next1": "day2_end",
		"next2": "day2_end"
	},
	"day2_end": {
		"dahlia_says": "i think you're overthinking it. i have to go, he's calling me. bye.",
		"opt1": "bye.",
		"opt2": "...",
		"is_end_of_day": true,
		"next_day": 3,
		"quote": "Even the sturdiest trees must bend in the wind.",
		"next_node": "day3_start"
	},

	# DAY 3
	"day3_start": {
		"dahlia_says": "hi. look, we need to talk about some stuff.",
		"opt1": "is this about him?",
		"opt2": "please don't do this.",
		"next1": "day3_final_1",
		"next2": "day3_final_2"
	},
	"day3_final_1": {
		"dahlia_says": "it's not 'about' him. it's about us. i just... i feel more like 'me' when I'm out with him lately.",
		"opt1": "are you being serious? after everything we’ve been through dahlia wow",
		"opt2": "it doesn’t have to be that way, we can work things out.",
		"next1": "game_over",
		"next2": "game_over"
	},
	"day3_final_2": {
		"dahlia_says": "i'm sorry. i just dont think i cant keep pretending everything is fine when it feels so heavy.",
		"opt1": "are you being serious? after everything we’ve been through",
		"opt2": "it doesn’t have to be that way, we can work things out.",
		"next1": "game_over",
		"next2": "game_over"
	},
	"game_over": {
		"dahlia_says": "i think i need some space. for real this time. i’m signing off. bye.",
		"is_game_end": true,
		"opt1": "...",
		"opt2" : "...",
		"quote": "Some things are meant to bloom for only a season."
	}
}
