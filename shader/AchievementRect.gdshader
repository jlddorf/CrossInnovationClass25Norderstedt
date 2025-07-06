shader_type canvas_item;

uniform float progress;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	if (UV.y < 1.0 - progress) {
		float average_color = (input_color.r + input_color.g + input_color.b) / 3.0;
		COLOR = vec4(average_color, average_color, average_color, input_color.a);
	}
	else {
		COLOR = input_color;
	}
}

//void light() {
//	// Called for every pixel for every light affecting the CanvasItem.
//	// Uncomment to replace the default light processing function with this one.
//}
