using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class rosstest : MonoBehaviour {

	// Use this for initialization
    void Start() {
        var mesh = GetComponent<MeshFilter>().mesh;
        Debug.Log(mesh);
        var uv = mesh.uv;
        var colors = new Color[uv.Length];

        // Instead if vertex.y we use uv.x
        for (var i = 0; i < uv.Length; i++)
            colors[i] = Color.Lerp(Color.red, Color.green, uv[i].x);

        mesh.colors = colors;
    }
}
