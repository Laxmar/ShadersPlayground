Shader "Playground/Blending2Textures"
{
	Properties
	{
		_MainTex ("Texture", 2D) = "white" {}
		_SecondTex("Second Texture", 2D) = "white" {}
		// Not used - go to line 53
		_LerpValue("Transition float ", Range(0, 1)) = 0.5
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
				UNITY_FOG_COORDS(1)
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;

			sampler2D _SecondTex;
			float _LerpValue;
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				// Uncomment and comment next line to use lerp value const in time
				// fixed4 col = lerp(tex2D(_MainTex, i.uv), tex2D(_SecondTex, i.uv), _LerpValue;

				// change _SinTime.w to speed up animation more info:
				// https://docs.unity3d.com/455/Documentation/Manual/SL-BuiltinValues.html
				fixed4 col = lerp(tex2D(_MainTex, i.uv), tex2D(_SecondTex, i.uv), abs( _SinTime.z));

				return col;
			}
			ENDCG
		}
	}
}
