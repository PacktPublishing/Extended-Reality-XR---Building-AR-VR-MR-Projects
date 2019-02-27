namespace VRTK.Examples
{
    using UnityEngine;

    public class GrabTrophy : VRTK_InteractableObject
    {
        public AudioClip otherClip;
        private VRTK_ControllerReference controllerReference;
        public  AudioSource audioSource;
        public AudioSource emulatorAudioSource;

        public override void Grabbed(VRTK_InteractGrab grabbingObject)
        {
            base.Grabbed(grabbingObject);
            controllerReference = VRTK_ControllerReference.GetControllerReference(grabbingObject.controllerEvents.gameObject);
            if (VRTK_ControllerReference.IsValid(controllerReference) && IsGrabbed())
            {
                VRTK_ControllerHaptics.TriggerHapticPulse(controllerReference, 0.5f, 0.5f, 0.01f);
                //strength, duration, pulse interval
                PlayAudio();
                //Glorious_Triumph
            }


        }

        public void PlayAudio()
        {
            if (audioSource.enabled == true)
            {
                audioSource.clip = otherClip;

                if (audioSource != null && !audioSource.isPlaying)
                {
                    audioSource.Play();
                }
            }

            if (emulatorAudioSource.enabled == true)
                {
                    emulatorAudioSource.clip = otherClip;

                    if (emulatorAudioSource != null && !emulatorAudioSource.isPlaying)
                    {
                        emulatorAudioSource.Play();
                    }
                }
        }

        public override void Ungrabbed(VRTK_InteractGrab previousGrabbingObject)
        {
            base.Ungrabbed(previousGrabbingObject);
            controllerReference = null;
        }
    }
}