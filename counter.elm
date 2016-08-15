import Html exposing (Html, button, div, text)
import Html.App as App
import Html.Events exposing (onClick)

initial_model =
  10

main =
  App.beginnerProgram { model = initial_model, view = view, update = update }

type Msg = Increment | Decrement | Restart

update msg model =
  case msg of
    Increment ->
      model + 10

    Decrement ->
      model - 10

    Restart ->
      initial_model

view model =
  div []
    [ button [ onClick Decrement ] [ text "-" ]
    , div [] [ text (toString model) ]
    , button [ onClick Increment ] [ text "+" ]
    , button [ onClick Restart ] [ text "Restart" ]
    ]

