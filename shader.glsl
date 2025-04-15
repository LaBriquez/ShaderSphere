#version 300 es
precision highp float;

const float PI = 3.141592653589793238462643383279f;

out vec4 out_color;

uniform vec2 u_resolution;

vec4 sphere = vec4(0.5, 2.0, 2.5, 1.0);

vec3 cam = vec3(1.0, 1.0, 0.0);

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - u_resolution) / u_resolution.y;

    vec3 N = normalize(vec3(uv.x, uv.y, 1.0));

    vec3 A = sphere.xyz - cam;
    float d = dot(A, A);
    float e = dot(A, N);
    float len = (d - e * e) / (sphere.w * sphere.w);
    vec3 p = e * N - sqrt(1.0 - len) * sphere.w * N;
    vec3 n = (p - A) / sphere.w;

    out_color = vec4(n * float(len < 1.0), 1.0);
}
