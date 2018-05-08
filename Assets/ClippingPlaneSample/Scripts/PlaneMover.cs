using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class PlaneMover : MonoBehaviour
{
	[SerializeField]
	private float _distance = 0.5f;

	[SerializeField]
	private float _speed = 1f;

	private Vector3 _initPos;

	private void Start()
	{
		_initPos = transform.position;
	}
	
	private void Update()
	{
		float t = Mathf.Sin(Time.time * _speed);
		Vector3 delta = transform.up * (t * _distance);
		transform.position = _initPos + delta;
	}
}
