shader_type canvas_item;

uniform float SCREEN_HEIGHT = 480.0;

void fragment() {
	int y_index = int(UV.y * SCREEN_HEIGHT);
	if (y_index % 2 == 0) {
		COLOR.a = 0.1;
	} else {
		COLOR.a = 0.0;
	}
}

