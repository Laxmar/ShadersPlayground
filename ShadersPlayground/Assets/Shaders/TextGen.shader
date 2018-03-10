Shader "TexGen/CubeNormal" {
	Properties{
		_Cube("Cubemap", Cube) = "" { /* used to be TexGen CubeNormal */ }
	}
		SubShader{
		Pass{
		CGPROGRAM
#pragma vertex vert
#pragma fragment frag
#include "UnityCG.cginc"

		struct v2f {
		float4 pos : SV_POSITION;
		float3 uv : TEXCOORD0;
	};

	v2f vert(float4 v : POSITION, float3 n : NORMAL)
	{
		v2f o;
		o.pos = UnityObjectToClipPos(v);

		// TexGen CubeNormal:
		// use view space normal of the object
		o.uv = mul((float3x3)UNITY_MATRIX_IT_MV, n);
		return o;
	}

	samplerCUBE _Cube;
	half4 frag(v2f i) : SV_Target
	{
		return texCUBE(_Cube, i.uv);
	}
		ENDCG
	}
	}
}