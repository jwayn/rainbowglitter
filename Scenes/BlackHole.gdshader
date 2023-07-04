shader_type canvas_item;

uniform sampler2D SCREEN_TEXTURE : hint_screen_texture, filter_linear_mipmap;
uniform sampler2D curve;
uniform float strength : hint_range(0, 1) = 0;
void fragment() {
	vec2 vec_to_center = vec2(0.5, 0.5) - UV;
	float dist_to_center = length(vec_to_center);
	float curve_val = texture(curve, vec2(dist_to_center)).r;
	vec2 diff = normalize(vec_to_center) * strength * curve_val;
	COLOR = texture(SCREEN_TEXTURE, SCREEN_UV - diff);
}
