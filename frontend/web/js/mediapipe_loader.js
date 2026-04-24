(function() {
  window.createPoseDetector = null;
  window.detectPose = null;
  window.getPoseData = null;

  async function init() {
    const { PoseLandmarker, FilesetResolver } = await import(
      'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.18/wasm'
    );
    const vision = await FilesetResolver.forVisionTasks(
      'https://cdn.jsdelivr.net/npm/@mediapipe/tasks-vision@0.10.18/wasm'
    );
    const detector = await PoseLandmarker.createFromOptions(vision, {
      baseOptions: {
        modelAssetPath:
          'https://storage.googleapis.com/mediapipe-models/pose_landmarker/pose_landmarker_lite/float16/1/pose_landmarker_lite.task',
        delegate: 'GPU',
      },
      runningMode: 'VIDEO',
      numPoses: 1,
    });

    window.createPoseDetector = async () => detector;
    window.detectPose = (video) =>
      detector.detectForVideo(video, performance.now());

    window.getPoseData = (video) => {
      const result = detector.detectForVideo(video, performance.now());
      if (result.landmarks && result.landmarks.length > 0) {
        return JSON.stringify(result.landmarks);
      }
      return '';
    };
  }

  init();
})();