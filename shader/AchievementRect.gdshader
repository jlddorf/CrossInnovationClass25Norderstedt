shader_type canvas_item;

uniform float progress;
uniform float randOffset;

void vertex() {
	// Called for every vertex the material is visible on.
}

void fragment() {
	vec4 input_color = texture(TEXTURE, UV);
	float updatedProgress = progress;
	if (progress > 0.001 && progress < 0.999) {
		updatedProgress = progress + 0.05 * sin(TIME * 4.0 + randOffset + UV.x);
	}
	if (UV.y < 1.0 - updatedProgress) {
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
