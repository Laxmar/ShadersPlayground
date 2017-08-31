using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimateBlending2Textures : MonoBehaviour
{

    public Material Mat;
    public float OffsetValue;
	
	void Update () {
		Mat.SetFloat("_LerpValue", OffsetValue + (Mathf.Sin(Time.time)) );
	}
}
