// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

// Upgrade NOTE: replaced '_Object2World' with 'unity_ObjectToWorld'
// Upgrade NOTE: replaced '_World2Object' with 'unity_WorldToObject'
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Playground/SpreadTriangles"
{
	Properties
	{
		_Color("Color", Color) = (1,0,0,1)
		_MainTex ("Texture", 2D) = "white" {}
		_MaxDistance("MaxDistance", Range(0,2)) = 0.5

	}
	SubShader
	{

	Tags { "RenderType"="Opaque"  }
	LOD 100

	Pass
	{

		CGPROGRAM
		#include "UnityCG.cginc"
		#pragma vertex vert
		#pragma geometry geom
		#pragma fragment frag

		sampler2D _MainTex;
		float4 _MainTex_ST;
		float _MaxDistance;

		struct appdata
		{
			float4 vertex : POSITION;
			float2 uv : TEXCOORD0;
		};

		struct v2g
		{
			float4 pos : SV_POSITION;
			float2 uv : TEXCOORD0;
		};

		struct g2f
		{
			float4 pos : SV_POSITION;
			float3 norm : NORMAL;
			float2 uv : TEXCOORD0;
		};

		v2g vert(appdata v)
		{
				v2g o;
				o.pos = v.vertex;
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				return o;
		}

		[maxvertexcount(3)]
		void geom(triangle v2g IN[3], inout TriangleStream<g2f>  triStream)
		{
			float3 v0 = IN[0].pos.xyz;
			float3 v1 = IN[1].pos.xyz;
			float3 v2 = IN[2].pos.xyz;

			float3 centerPos = (v0 + v1 + v2) / 3.0;
			float3 vn = normalize(cross(v1 - v0, v2 - v0));
			float3 normalDirection = normalize(mul(float4(vn, 0.0), unity_WorldToObject).xyz);

			float m = _MaxDistance * abs( _SinTime.z);

			v0 += m * normalDirection;
			v1 += m * normalDirection;
			v2 += m * normalDirection;

			IN[0].pos.xyz = v0;
			IN[1].pos.xyz = v1;
			IN[2].pos.xyz = v2;
			
			g2f OUT;
			OUT.pos = UnityObjectToClipPos (IN[0].pos);
			OUT.norm = vn;
			OUT.uv = IN[0].uv;
			triStream.Append(OUT);

			OUT.pos = UnityObjectToClipPos(IN[1].pos) ;
			OUT.norm = vn;
			OUT.uv = IN[1].uv;
			triStream.Append(OUT);

			OUT.pos = UnityObjectToClipPos(IN[2].pos) ;
			OUT.norm = vn;
			OUT.uv = IN[2].uv;
			triStream.Append(OUT);
		}

		half4 frag(g2f IN) : COLOR
		{
				fixed4 col = tex2D(_MainTex, IN.uv);
				return col;
		}

		ENDCG

		}
	}
}