import { shaderMaterial, useTexture } from "@react-three/drei"
import { extend } from "@react-three/fiber"
import vertexShader from './shaders/vertex.glsl'
import fragmentShader from './shaders/fragment.glsl'
import { Color, MirroredRepeatWrapping, NearestFilter, SRGBColorSpace } from "three"

export default function MeshSparkleMaterial({
    texture = './images/noise.png', // default texture
    sparkleScale = 1, // scale up noise size
    sparkleIntensity = 1, // intensity of sparkles
    baseColor = '#101010', // base color
    fresnelColor = '#e1c564', // fresnel color
    sparkleColor = '#e1c564', // sparkle color
    fresenlAmt = 2, // amount of fresnel
    fresnelAlpha = 1, // fresnel alpha
    fresnelIntensity = 5, // brightness of fresnel
})
{

    // noise texture
    const noise = useTexture( texture )
    noise.wrapS = MirroredRepeatWrapping
    noise.wrapT = MirroredRepeatWrapping
    noise.magFilter = NearestFilter
    noise.minFilter = NearestFilter
    noise.colorSpace = SRGBColorSpace

    const uniforms = {
        uNoiseTexture: noise,
        uScale: sparkleScale,
        uIntensity: sparkleIntensity * 10,
        uBaseColor: new Color( baseColor ),
        uFresnelColor: new Color( fresnelColor ),
        uSparkleColor: new Color( sparkleColor ),
        uFresnelAmt: fresenlAmt,
        uFresnelAlpha: fresnelAlpha,
        ufresnelIntensity: fresnelIntensity,
    }

    const MeshSparkleMaterial = shaderMaterial( uniforms, vertexShader, fragmentShader )

    extend({ MeshSparkleMaterial })

    return(
        <meshSparkleMaterial
            key={ MeshSparkleMaterial.key }
            transparent={ true }
        />
    )
}