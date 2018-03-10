Shader "Playground/Spotlight"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		[PerRendererData]_CharacterPostion("Char pos", vector) = (0,0,0,0)
		_CicleRadius("Spotlight size", Range(0,20)) = 3
		_RingSize("Ring size", Range(0,5)) = 1
		_ColorTint("Outside of the spotlight color", Color) = (0,0,0,0)
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag

			
			#include "UnityCG.cginc"

			struct appdata
			{
				float4 vertex : POSITION;
				float2 uv : TEXCOORD0;
			};

			struct v2f
			{
				float2 uv : TEXCOORD0;
				float4 vertex : SV_POSITION;

				float dis :  TEXCOORD1;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			float4 _CharacterPostion;
			float _CicleRadius;
			float _RingSize;
			float4 _ColorTint;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				float3 worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.dis = distance(worldPos, _CharacterPostion.xyz);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				fixed4 col = _ColorTint;

				if (i.dis < _CicleRadius) {
					col = tex2D(_MainTex, i.uv);
				}
				if (i.dis > _CicleRadius && i.dis < _RingSize) {
					float stregthBlend = i.dis - _CicleRadius;
					col = lerp(tex2D(_MainTex, i.uv), _ColorTint, stregthBlend / _RingSize);
				}

				
				return col;
			}
			ENDCG
		}
	}
}
