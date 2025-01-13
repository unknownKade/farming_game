extends Node

class_name State

signal Transition

func enter():
	pass

func exit():
	Transition.emit(self)
