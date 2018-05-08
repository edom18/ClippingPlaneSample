Shader "Unlit/ClippingPlane"
{
	Properties
	{
		[Toggle] _Positive("Cull Positive", Float) = 1
		_PlaneCount("Plane count", Range(0, 10)) = 0
		_MainTex ("Texture", 2D) = "white" {}
	}
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 100

		Pass
		{
			Cull Off

			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma multi_compile_fog
			
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
				float4 viewVertex : TEXCOORD2;
				float4 vertex : SV_POSITION;
			};

			sampler2D _MainTex;
			float4 _MainTex_ST;
			float _Positive;
			uniform float _PlaneCount;
			uniform float4 _ClippingPlanes[10];
			
			v2f vert (appdata v)
			{
				v2f o;
				o.vertex = UnityObjectToClipPos(v.vertex);
				o.uv = TRANSFORM_TEX(v.uv, _MainTex);
				UNITY_TRANSFER_FOG(o,o.vertex);
				o.viewVertex = mul(UNITY_MATRIX_MV, v.vertex);
				return o;
			}
			
			fixed4 frag (v2f i) : SV_Target
			{
				int count = int(_PlaneCount);
				for (int idx = 0; idx < count; idx++)
				{
					float4 plane = _ClippingPlanes[idx];
					if (_Positive == 0)
					{
						if (dot(plane.xyz, i.viewVertex.xyz) > plane.w)
						{
							discard;
						}
					}
					else 
					{
						if (dot(plane.xyz, i.viewVertex.xyz) < plane.w)
						{
							discard;
						}
					}
				}

				fixed4 col = tex2D(_MainTex, i.uv);
				UNITY_APPLY_FOG(i.fogCoord, col);
				return col;
			}
			ENDCG
		}
	}
}
