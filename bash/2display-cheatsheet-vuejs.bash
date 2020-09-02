#!/usr/bin/env bash
echo '
- shorthand
	: (v-bind:)
	@ (v-on:), src directory
	# (v-slot:)
- Rule of Thumb
	method or computed properties? -> change data or change its presentation
	data or props in component? -> data is private for each component, props data is dependent upon parent
	slot or props? -> slot when pass html or markup to component, props when pass data to component
- Vuex
	actions (trigger mutations) vs mutations (responsible for state changes) vs dispatch (trigger actions)
- Vue cli
	assets (processed by webpack) vs static folders
'
