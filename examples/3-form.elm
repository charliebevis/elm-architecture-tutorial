import Html exposing (..)
import Html.App as Html
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import String exposing (toInt)


main =
  Html.beginnerProgram
    { model = model
    , view = view
    , update = update
    }



-- MODEL


type alias Model =
  { name : String
  , age : String
  , password : String
  , passwordAgain : String
  }


model : Model
model =
  Model "" "" "" ""



-- UPDATE


type Msg
    = Name String
    | Age String
    | Password String
    | PasswordAgain String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Age age ->
      { model | age = age}

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }



-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ type' "text", placeholder "Name", onInput Name ] []
    , input [ type' "number", placeholder "Age", onInput Age ] []
    , input [ type' "password", placeholder "Password", onInput Password ] []
    , input [ type' "password", placeholder "Re-enter Password", onInput PasswordAgain ] []
    , viewValidation model
    ]


passwordsDoNotMatch model = model.password /= model.passwordAgain

ageIsPositive model = case (String.toInt (model.age)) of
  Err _ -> False
  Ok _ -> True

viewValidation : Model -> Html msg
viewValidation model =
  let
    (color, message) =
      if (passwordsDoNotMatch model) then
        ("red", "Passwords do not match!")
      else
      if (not(ageIsPositive model)) then
        ("red", "Age is not positive!")
      else
        ("green", "OK")
  in
    div [ style [("color", color)] ] [ text message ]
