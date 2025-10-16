shader_type canvas_item;

uniform float flash_intensity : hint_range(0.0, 1.0) = 0.0;
uniform vec4 flash_color : source_color = vec4(1.0, 1.0, 1.0, 1.0);

void fragment() {
    vec4 base_color = texture(TEXTURE, UV);
    // Blend between normal color and flash color
    COLOR = mix(base_color, flash_color, flash_intensity);
}
