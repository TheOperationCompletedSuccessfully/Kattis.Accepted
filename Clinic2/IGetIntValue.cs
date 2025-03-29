using Clinic;

namespace Zeva
{
   public interface IGetIntValue<T> where T : class
   {
      long GetValue(int time);
      long Compare(T other, int time);
   }
}
