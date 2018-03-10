using System.Collections;
using System.Collections.Generic;
using System.Linq;
using UnityEngine;

public class UpdatePlayerPosition : MonoBehaviour
{
    public Transform PlayerTransform;

    private Renderer _renderer;
    private MaterialPropertyBlock _propBlock;

	void Start () {
	    _propBlock = new MaterialPropertyBlock();
	    _renderer = GetComponent<Renderer>();
    }
	
	// Update is called once per frame
	void Update () {
	    _renderer.GetPropertyBlock(_propBlock);
        _propBlock.SetVector("_CharacterPostion", PlayerTransform.position);
	    _renderer.SetPropertyBlock(_propBlock);

	    string s = "a(bc)de";
	    List<char> l = s.ToList();
	    string[] a = s.Split('(', ')');

	    string res = "";

	    int midIndex = (a.Length - 1)/ 2;

        string temp = a[midIndex].Reverse().ToString();
	    res += temp;
	    // len=3 mid =1 i=0

        for (int i=1; midIndex + i < a.Length; i++)
        {
            res = a[midIndex - i] + res + a[midIndex + i];

        }


    }
}
