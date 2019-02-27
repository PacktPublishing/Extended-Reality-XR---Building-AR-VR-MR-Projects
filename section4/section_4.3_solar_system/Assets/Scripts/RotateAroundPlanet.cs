using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class RotateAroundPlanet : MonoBehaviour
{
    public float speed = 1f;
    public GameObject objectToRotateAround;

    // Start is called before the first frame update
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        transform.RotateAround(
            objectToRotateAround.transform.position,
            Vector3.up,
            speed * Time.deltaTime);

    }
}
