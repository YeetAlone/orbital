import 'package:flutter/material.dart';

class TermsOfService extends StatelessWidget {
  const TermsOfService({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children:[
          SizedBox(height:80),
          Center(child: Text("TERMS OF SERVICE",textAlign: TextAlign.center,style: TextStyle(color:Colors.white,fontSize: 20))),
          SizedBox(height:80),
          Text("Lorem ipsum dolor sit amet. Ea esse nesciunt qui labore recusandae est alias molestiae? Ea quasi dolore eum iste quia qui obcaecati ullam rem explicabo eius et quisquam corrupti. Qui commodi eius id enim velit et corrupti molestiae sed accusantium labore 33 nostrum velit.", textAlign: TextAlign.center,style: TextStyle(color:Colors.white)),
          Text("Lorem ipsum dolor sit amet. Ea esse nesciunt qui labore recusandae est alias molestiae? Ea quasi dolore eum iste quia qui obcaecati ullam rem explicabo eius et quisquam corrupti. Qui commodi eius id enim velit et corrupti molestiae sed accusantium labore 33 nostrum velit.", textAlign: TextAlign.center,style: TextStyle(color:Colors.white)),
          Text("Lorem ipsum dolor sit amet. Ea esse nesciunt qui labore recusandae est alias molestiae? Ea quasi dolore eum iste quia qui obcaecati ullam rem explicabo eius et quisquam corrupti. Qui commodi eius id enim velit et corrupti molestiae sed accusantium labore 33 nostrum velit.", textAlign: TextAlign.center,style: TextStyle(color:Colors.white)),
          Text("Lorem ipsum dolor sit amet. Ea esse nesciunt qui labore recusandae est alias molestiae? Ea quasi dolore eum iste quia qui obcaecati ullam rem explicabo eius et quisquam corrupti. Qui commodi eius id enim velit et corrupti molestiae sed accusantium labore 33 nostrum velit.", textAlign: TextAlign.center,style: TextStyle(color:Colors.white)),
          Text("Lorem ipsum dolor sit amet. Ea esse nesciunt qui labore recusandae est alias molestiae? Ea quasi dolore eum iste quia qui obcaecati ullam rem explicabo eius et quisquam corrupti. Qui commodi eius id enim velit et corrupti molestiae sed accusantium labore 33 nostrum velit.", textAlign: TextAlign.center,style: TextStyle(color:Colors.white)),
          ]
      ),
    );
  }
}
