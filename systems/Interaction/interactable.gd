extends Area3D

class_name Interactable

@export var object: PhysicsBody3D
var grabbable = false

signal focused(interactor: Interactor)
signal unfocused(interactor: Interactor)
signal interacted(interactor: Interactor)
