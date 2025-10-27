extends CharacterBody2D
class_name Entity
"""Base Class ของทุกๆ สิ่งๆ ที่สามารถรับ damage รับ status effect ได้"""

signal _entity_died
signal _object_died
"""Enity Stats"""
var base_move_speed = 1.0
var is_died: bool = false
