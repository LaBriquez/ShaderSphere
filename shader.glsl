precision highp float;

uniform vec2 resolution;
uniform sampler2D test;

const float PI = 3.141592653589793;

vec4 sphere = vec4(-1.0, -2.0, 5.0, 2.0);

void main() {
    vec2 uv = (gl_FragCoord.xy * 2.0 - resolution.xy) / resolution.x;
    vec3 N = normalize(vec3(uv.x, uv.y, 1.0));

    vec3 A = dot(sphere.xyz, N) * N;
    vec3 dir = A - sphere.xyz;
    float len = dot(dir, dir) / (sphere.w * sphere.w);
    vec3 normal = (A - sqrt(1.0 - len) * sphere.w * N - sphere.xyz) / sphere.w;

    vec3 color = texture2D(test, vec2((atan(normal.z, normal.x) + PI) / (2.0 * PI), normal.y * 0.5f + 0.5f)).rgb;

    gl_FragColor = vec4(color * float(len < 1.0), 1.0);
}
