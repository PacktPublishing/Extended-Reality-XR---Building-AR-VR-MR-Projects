using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.XR.WSA.Input;

public class GazeGestureManager : MonoBehaviour {

    public static GazeGestureManager GazeInstance { get; private set; }
    public static GameObject FocusedObject { get; private set; }
    GestureRecognizer recognizer;

    Animator animator;

    private void Awake()
    {
        GazeInstance = this;

        recognizer = new GestureRecognizer();
        recognizer.Tapped += (args) =>
        {
            if(FocusedObject != null)
            {
                Debug.Log("Tap Gesture using Space Bar");

                animator = FocusedObject.GetComponentInParent<Animator>();

                if(animator.speed == 0)
                {
                    animator.speed = 0.7f;
                } else
                {
                    animator.speed = 0.0f;
                }
            }
        };
        recognizer.StartCapturingGestures();
    }
    
	// Update is called once per frame
	void Update () {
        GameObject oldObject = FocusedObject;

        var headPosition = Camera.main.transform.position;
        var gazeDirection = Camera.main.transform.forward;

        RaycastHit hitInfo;

        if (Physics.Raycast(headPosition, gazeDirection, out hitInfo))
        {
            FocusedObject = hitInfo.collider.gameObject;
        } else
        {
            FocusedObject = null;
        }

        if (FocusedObject != oldObject)
        {
            recognizer.CancelGestures();
            recognizer.StartCapturingGestures();
        }
	}
}
