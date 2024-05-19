shader_type canvas_item;

uniform vec4 target_color : source_color;
uniform float threshold : hint_range(0.0, 1.0);

void fragment() {
    vec4 tex_color = texture(TEXTURE, UV);
    if (distance(tex_color.rgb, target_color.rgb) < threshold) {
        tex_color.a = 0.0;
    }
    COLOR = tex_color;
}
