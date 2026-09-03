class_name OfferDef
extends Resource

@export var id: String = ""
@export var sku: String = ""
@export var kind: String = "cosmetic"
@export var price_tier: int = 1
@export var grants: Dictionary = {}

func get_id() -> String:
	return id
