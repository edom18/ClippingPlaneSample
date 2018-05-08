using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ClippingPlanes : MonoBehaviour
{
	[SerializeField]
	private Transform[] _clippingPlanes;

	private Material _material;

	private void Awake()
	{
		_material = GetComponent<MeshRenderer>().material;
	}

	private void Update()
	{
		Vector4[] planes = new Vector4[_clippingPlanes.Length];
		Matrix4x4 viewMatrix = Camera.main.worldToCameraMatrix;

		for (int i = 0; i < planes.Length; i++)
		{
			Vector3 viewUp = viewMatrix.MultiplyVector(_clippingPlanes[i].up);
			Vector3 viewPos = viewMatrix.MultiplyPoint(_clippingPlanes[i].position);
			float distance = Vector3.Dot(viewUp, viewPos);
			planes[i] = new Vector4(viewUp.x, viewUp.y, viewUp.z, distance);
		}

		_material.SetVectorArray("_ClippingPlanes", planes);
	}
}
