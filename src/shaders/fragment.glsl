uniform sampler2D uNoiseTexture;
uniform float uScale;
uniform float uIntensity;
uniform vec3 uBaseColor;
uniform vec3 uFresnelColor;
uniform float uFresnelAmt;
uniform float uFresnelAlpha;
uniform vec3 uSparkleColor;
uniform float ufresnelIntensity;

varying vec3 vNormal;
varying vec3 vPosition;
varying vec2 vUv;

void main()
{
    vec2 uv = vUv * 0.5 + 0.5;

    vec3 viewDirection = normalize( vPosition - cameraPosition );
    vec3 view = normalize( cameraPosition - vPosition );
    vec3 normal = normalize( vNormal );

    vec4 noiseTexture = texture( uNoiseTexture, uv * uScale );
    vec3 sparkleMap = noiseTexture.rgb;
    sparkleMap -= vec3( 0.5 );
    sparkleMap = normalize( normalize( sparkleMap ) + normal );

    float sparkle = dot( -viewDirection, sparkleMap ); // sparkle calculation
    float clampedSparkle = clamp( sparkle, 0.0, 1.0 ); // restrict to 0-1 range
    sparkle = pow( clampedSparkle, uIntensity ); // increase darkness to reduce sparkles

    float fresnel = pow( dot( normal, viewDirection ) + 1.0, uFresnelAmt ); // fresnel calculation
    float diffuse = dot( normal, view ); // lambert lighting calculation
    diffuse = max( diffuse, 0.0 );

    vec3 color = uBaseColor;
    color *= diffuse;
    vec4 fresnelColor = vec4( uFresnelColor, 1.0 );
    fresnelColor.rgb *= fresnel;
    fresnelColor *= ufresnelIntensity;

    vec4 sparkleColor = vec4( uSparkleColor, 0.0 );
    sparkleColor.rgb *= sparkle;
    
    vec4 finalColor = vec4( color, 1.0 );

    finalColor += sparkleColor;
    finalColor = mix(finalColor, fresnelColor, fresnel * uFresnelAlpha);



    gl_FragColor = finalColor;
    #include <tonemapping_fragment>
    #include <colorspace_fragment>

}