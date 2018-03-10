Shader "Unlit/CutExperiments"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_Distance("_Distance", Range(0, 2)) = 0
		_Point("_Point", Vector) = (0,0,0,0)

		_PlaneNormal("PlaneNormal",Vector) = (0,1,0,0)
		_PlanePosition("PlanePosition",Vector) = (0,0,0,1)

	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100
		Cull Off


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
				float3 worldPos : TEXCOORD2;
			};


			fixed3 _PlaneNormal;
			fixed3 _PlanePosition;


			bool checkVisability(fixed3 worldPos)
			{
				float dotProd1 = dot(worldPos - _PlanePosition, _PlaneNormal);
				return dotProd1 >0;
			}

			sampler2D _MainTex;
			float4 _MainTex_ST;

			float _Distance;
			float4 _Point;

			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.worldPos = mul(unity_ObjectToWorld, v.vertex).xyz;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);

				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				if (checkVisability(i.worldPos))discard;

				fixed4 col = lerp(float4(1, 0, 0, 1), float4(0, 0, 1, 1), distance(i.worldPos, _Point));

				return col;
			}
			ENDCG
		}
	}
}
