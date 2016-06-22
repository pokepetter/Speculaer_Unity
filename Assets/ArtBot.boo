import UnityEngine
import System.Collections
import System.IO
import UnityEngine.UI

class ArtBot (MonoBehaviour): 

    public build as bool
    public save as bool

    public layers as (GameObject)
    public images as (Texture)

    public x as single
    public y as single
    public p as Matrix4x4
    
    public i as int
    public j as int

    public currentDirectory as string
    public files as (string)
    private cam as Camera
    public savePath as Text
    public gui as GameObject

    public static inputFolder as string
    
    def Awake():
        Screen.SetResolution(720,720,false)
        inputFolder = "Input"
        cam = transform.GetComponent(Camera)
        p = cam.projectionMatrix
        cam.projectionMatrix = p
        savePath.text = Directory.GetParent(Application.dataPath).FullName + "\\" + "Output" + "\\"
        # parentDirectory = Directory.GetParent(Application.dataPath).FullName

    def Build():
        currentDirectory = Directory.GetCurrentDirectory() + "\\" + inputFolder
        files = System.IO.Directory.GetFileSystemEntries(currentDirectory, "*.jpg")

        for layer in layers:
            if Random.value <= 0.5:
                layer.transform.localScale.x *= -1
             
         
            layer.GetComponent[of Renderer]().sharedMaterial.mainTexture = LoadPng(Mathf.RoundToInt(Random.Range(0,files.Length)))
            layer.transform.position = Vector3(Random.Range(-1.5f,1.5f),Random.Range(-1.5f,1.5f),layer.transform.position.z)
            layer.transform.rotation.eulerAngles.z = Mathf.Round(Random.Range(0,360)/90)*90


    def LoadPng(i as int) as Texture2D:
        tex as Texture2D
        if File.Exists(files[i]):
            fileData = File.ReadAllBytes(files[i])
            tex = Texture2D(2, 2)
            tex.LoadImage(fileData)//..this will auto-resize the texture dimensions.
            return tex
        
    def Save():
        StartCoroutine(SaveRoutine())

    def SaveRoutine() as IEnumerator:
        gui.SetActive(false)
        yield WaitForEndOfFrame()
        Application.CaptureScreenshot(Directory.GetParent(Application.dataPath).FullName + "\\" + "Output" + "\\" 
            + "artbot_" + System.DateTime.Now.ToString("yyyyMMddHHmmssFFF") + ".png")
        yield WaitForEndOfFrame()
        gui.SetActive(true)

    def Update():
        if build == true or Input.GetKeyDown(KeyCode.R):
            Build()
            build = false
            
        if save == true or Input.GetKeyDown(KeyCode.S):
            Save()
            save = false
