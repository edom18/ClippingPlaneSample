using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraMover : MonoBehaviour
{
	[SerializeField]
	private Transform _target;

	[SerializeField]
	private float _distance;
	
	private void Update()
	{
		float x = Mathf.Cos(Time.time) * _distance;
		float z = Mathf.Sin(Time.time) * _distance;
		Vector3 pos = transform.position;
		pos.x = x;
		pos.z = z;
		transform.position = _target.position + pos;
		transform.LookAt(_target);
	}
}
