import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String
import List
import Regex exposing (..)



main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { content : String
  }


model : Model
model =
  Model ""



-- UPDATE


type Msg
  = Change String

update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }

firstLetters : String -> String
firstLetters =
  replace All (regex "\\B\\w") (\_ -> "_")

firstWords : String -> String
firstWords =
  replace All (regex "\\s(.*)") (\_ -> "\n")

newLineHandler : String -> List (Html msg)
newLineHandler textBox =
  textBox
    |> String.split "\n"
    |> List.map Html.text
    |> List.intersperse ( br [] [] )

-- VIEW

place = """Text to \n
filter"""

view : Model -> Html Msg
view model =
  div []
    [ textarea [ placeholder "Fill this \n in", onInput Change ] []
    , div [] [ text "Hello",  br [] [], text "World" ]
    , div [] [ text (firstLetters model.content) ]
    , div [] [ text (firstWords model.content) ]
    , div [] ( newLineHandler model.content )
    ]
