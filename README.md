#AdjustViewWhenHitTextField

# Tutorial em português
[Ir para tutorial em português!](#portugues)

### English

# Description, Why?
Easy description of how adjust views that has UITextField and when keyboard show up text field stayed behind keyboard.
This tutorial its just a simple example that how we make view scroll up and back to original state after keyboard show and the tapped UITextField stayed behind keyboard.

That could be applied for any object that of kind UIView, for example: UILabel, UIButton.

#Tutorial

Download project and see how we created or view, most important to know is, the right way in this case is use UIScrollView, that because if we handle with our UIView some weird situations, like a black view behind happens.   

#Code
First at viewDidLoad method insert this notifications

```swift
// Set observer for receive keyboard notifications
NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWasShown:", name:"UIKeyboardDidShowNotification", object:nil)

NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:", name:"UIKeyboardWillHideNotification", object:nil)

NSNotificationCenter.defaultCenter().addObserver(self, selector:"userTappedOnField:", name:"UITextFieldTextDidBeginEditingNotification", object:nil)
```

Now we will create methods that will be called when keyboard will show up and dismiss

```swift
// View readjust actions
   func keyboardWasShown(notification: NSNotification) {

       let info:NSDictionary = notification.userInfo!

       let keyboardSize:CGSize = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size)!

       let txtFieldView:CGPoint = selectedField!.frame.origin;

       let txtFieldViewHeight:CGFloat = selectedField!.frame.size.height;

       var visibleRect:CGRect = viewInsideScroll!.frame;

       visibleRect.size.height -= keyboardSize.height;


       if !CGRectContainsPoint(visibleRect, txtFieldView) {
           let scrollPoint:CGPoint = CGPointMake(0.0, txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5))

           scrollView?.setContentOffset(scrollPoint, animated: true)
       }

   }

   func keyboardWillBeHidden(notification: NSNotification) {
       scrollView?.setContentOffset(CGPointZero, animated: true)
   }

```

Now you will see that we are getting our field size, and for that i created a helper method that will "save" which UITextField was select for we get size and other informations.

First create a property in our interface:
```swift
var selectedField:UITextField?
```

Now create the method that will receive UITextfield notification, we already attached notification at viewDidLoad:
```swift
func userTappedOnField(txtSelected: NSNotification){
       if txtSelected.object is UITextField {
          selectedField = txtSelected.object as? UITextField
       }
   }
```

Now its done, download or project to see finished, has one or other helper, but with just this code everything was fine.

#Tip

If you don't want handle all this thinks just use a UITableView, when your view is inside UITableView, the table view will handle this scroll situation without any other implementation.

# English Tutorial
[Go to top](#english)

### Portugues

# Descrição, porquê desse exemplo?
Simples demonstração de como reajustar um UIView quando temos nela um ou vários UITextField e ao selecionar e o teclado subir ou esconder nos garantimos que o UITextField não irá ficar atrás do teclado.

Esse conceito pode ser aplicado para qualquer objeto to tipo UIView, por exemplo: UILabel, UIbutton.

#Tutorial

Faça o download / fork do projeto e veja como criamos nossa view, o mais importante a saber, é que a maneira correta nesse caso é usando uma UIScrollView, isso porquê se alterarmos direto nossa UIView poderá acontecer algumas situações estranhas, como uma "view" preta no fundo.

#Código
Primeito no método viewDidLoad insira essa notificações

```swift
// Set observer for receive keyboard notifications
NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWasShown:", name:"UIKeyboardDidShowNotification", object:nil)

NSNotificationCenter.defaultCenter().addObserver(self, selector:"keyboardWillBeHidden:", name:"UIKeyboardWillHideNotification", object:nil)

NSNotificationCenter.defaultCenter().addObserver(self, selector:"userTappedOnField:", name:"UITextFieldTextDidBeginEditingNotification", object:nil)
```

Agora nós vamos criar os métodos que irão lidar com o teclado quando ele subir e descer.

```swift
// View readjust actions
   func keyboardWasShown(notification: NSNotification) {

       let info:NSDictionary = notification.userInfo!

       let keyboardSize:CGSize = (info.objectForKey(UIKeyboardFrameBeginUserInfoKey)?.CGRectValue.size)!

       let txtFieldView:CGPoint = selectedField!.frame.origin;

       let txtFieldViewHeight:CGFloat = selectedField!.frame.size.height;

       var visibleRect:CGRect = viewInsideScroll!.frame;

       visibleRect.size.height -= keyboardSize.height;


       if !CGRectContainsPoint(visibleRect, txtFieldView) {
           let scrollPoint:CGPoint = CGPointMake(0.0, txtFieldView.y - visibleRect.size.height + (txtFieldViewHeight * 1.5))

           scrollView?.setContentOffset(scrollPoint, animated: true)
       }

   }

   func keyboardWillBeHidden(notification: NSNotification) {
       scrollView?.setContentOffset(CGPointZero, animated: true)
   }

```

Agora você irá ver que estamos pegando a UITextField selecionada, e para isso eu criei um método de auxílio que "salva" qual UITextField foi selecionado para poder pegar o tamanos e outras informações.

Primeiro crie uma propriedade na nossa interface:
```swift
var selectedField:UITextField?
```
Agora crie o método que irá receber os eventos de clique no nosso UITextField, nós inserimos essa notificação no nosso viewDidLoad:

```swift
func userTappedOnField(txtSelected: NSNotification){
       if txtSelected.object is UITextField {
          selectedField = txtSelected.object as? UITextField
       }
   }
```

Agora esta pronto, faça download do projeto terminado, tem mais um ou dois itens de auxílio lá, mas somente com o código aqui demonstrado esta completo.

#Dica

Se você não quer lidar com todas essa notificações, é simples, é só usar um UITableView. Quando sua view esta dentro de uma UITableView, a table view irá lidar com todas essas situações de scroll sem nenhuma implementação.
