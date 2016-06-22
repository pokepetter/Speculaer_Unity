import UnityEngine
import System.Collections
import System.IO

class FolderButton (MonoBehaviour): 

    public folderName as string

    public def Click():
        folderName = transform.GetChild(0).GetComponent(Text).text
        inputFolderChanger = transform.parent.GetComponent(InputFolderChanger)
        inputFolderChanger.SetInputFolder(folderName)
        inputFolderChanger.Click()
