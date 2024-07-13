```
init->\
      |
    (Core)
      |
      {->VimOption--\
      |             |
      |             {->LanguageOption
      |             |
      |             {->EditorOption--\
      |             |                |
      |             |                {->EditorDeviceExtension
      |             |                |
      |             |                {->EditorIndentation
      |             |                |
      |             |                \->EditorSearch
      |             |
      |             \->UIOption--\
      |                          |
      |                          {->UILineOption
      |                          |
      |                          \->UIWindowOption
      |
      {->KeyMap
      |
      \->PluginManager--\
                        |
                     (Plugin)
                        |
                        {---->\
                        |     |
                        |  (Plugin)
                        |  (Packge)
                        |  (Manage)
                        |     |
                        |     {->PluginList
                        |     \->PluginManagerOption
                        |
                        \->PluginOptionLoad-->PluginUI--\
                                                        |
                                                        {->UITheme
                                                        |
                                                        {->UIGreeter
                                                        |
                                                        {->UILine--\
                                                        |          |
                                                        |          {->UILineStatus
                                                        |          |
                                                        |          {->UILineBuffer
                                                        |          |
                                                        |          \->UILineScroll
                                                        |
                                                        {->UIIndentation
                                                        |
                                                        \->UITree
```