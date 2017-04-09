// Type: ShittyWebcam.Program
// Assembly: ShittyWebcam, Version=1.0.0.0, Culture=neutral, PublicKeyToken=null
// MVID: 814D44E8-97A1-4778-9408-0FCDE674103E
// Assembly location: J:\ShittyWebcam\ShittyWebcam.exe

using System;
using System.Net.Sockets;
using System.Text;

namespace ShittyWebcam
{
  internal class Program
  {
    private static void Main(string[] args)
    {
      UdpClient udpClient = new UdpClient();
      string str = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";
      char[] chArray = new char[8];
      Random random = new Random();
      udpClient.Connect("127.0.0.1", 1337);
      while (true)
      {
        for (int index = 0; index < chArray.Length; ++index)
          chArray[index] = str[random.Next(str.Length)];
        byte[] bytes = Encoding.ASCII.GetBytes(new string(chArray));
        udpClient.Send(bytes, bytes.Length);
      }
    }
  }
}