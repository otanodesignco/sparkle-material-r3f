

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

void main()
{

    vNormal = (modelMatrix * vec4( normal, 0.0 )).xyz;
    // Position
    vec4 modelPosition = modelMatrix * vec4(position, 1.0);

    // Final position
    gl_Position = projectionMatrix * viewMatrix * modelPosition;

    // Varyings
    vPosition = modelPosition.xyz;
    vUv = uv;

}