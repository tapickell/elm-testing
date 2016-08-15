import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Html.App as App

main =
  App.beginnerProgram { model = model
                      , view = view
                      , update = update
                      }

-- Model

type alias Model =
  List Status

type alias Status =
  { appName : String
  , appStatus : String
  }

model : Model
model =
  [ { appName = "a", appStatus = "enqueued" }
  , { appName = "b", appStatus = "started" }
  , { appName = "c", appStatus = "completed" }
  , { appName = "d", appStatus = "stopped"}
  ]

-- Update

-- NewStatus gets called from WebSockets with statusUpdate

type Msg
  = NewStatus Status

update : Msg -> Model -> Model
update msg model =
  case msg of
    NewStatus statusUpdate ->
      updateStatii statusUpdate model

updateStatii : Status -> Model -> Model
updateStatii update statii =
  if statusExists update statii then
    [update] ++ List.filter (\{appName} -> appName /= update.appName) statii
  else
    update::statii

statusExists : Status -> Model -> Bool
statusExists update statii =
  List.any (\{appName} -> appName == update.appName) statii

-- View

view : Model -> Html Msg
view model =
  let th' field = th [] [ text field ]
      tr' status = tr [] [ td [] [text status.appName]
                         , td [] [text status.appStatus]]

  in
    div []
      [ h1 [ class "page-header" ] [ text "This is status!"]
      , div [ class "statii-table" ]
        [ table [ class "table"]
          [ thead [] [tr [] (List.map th' ["App Name", "Status"])]
          , tbody [] (List.map tr' model)
          ]
        ]
      ]
