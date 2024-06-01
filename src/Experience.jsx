import { Center, OrbitControls } from '@react-three/drei'

import { Skag } from './Skag'

export default function Experience()
{

    return <>

        <OrbitControls 
            makeDefault
            enableZoom={false}
            enableDamping
        />

        <Center>
            <Skag
                scale={3.3}
            />
        </Center>

    </>
}