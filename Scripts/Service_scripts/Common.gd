extends Node

func find_real_parent(node: Node, class_your_want_to_find):
	if is_instance_of(node, class_your_want_to_find):
		return node
	print(node)
	print(node.get_parent(), "--------")
	find_real_parent(node.get_parent(), class_your_want_to_find)
	
static func get_component(node: Node, class_you_want_to_find_in_that_node): #get_parent() #StatComponent
	if is_instance_of(node, class_you_want_to_find_in_that_node):
		return node
	for child in node.get_children():
		print(child)
		var found = get_component(child, class_you_want_to_find_in_that_node)
		if found:
			return found
	return null #BEWARE OF TOO MUCH RECURSION











static func try_get_meta(node: Node, meta : String, val = null):
	if node.has_meta(meta):
		return true
	else:
		node.set_meta(meta, val)
	return false
