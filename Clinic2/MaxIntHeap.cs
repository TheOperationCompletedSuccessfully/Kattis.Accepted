using System.Collections;
using Zeva;

namespace Clinic
{
    public class MaxIntHeap<T> : ArrayList where T : class, IGetIntValue<T>
    {
        public T Pop(int time)
        {
            var result = base[0];
            base[0] = base[Count - 1];
            base.RemoveAt(Count - 1);
            BubbleDown(0, time);
            return (T)result;
        }

        public T Peek()
        {
            return (T)base[0];
        }


        private void BubbleDown(int index, int time)
        {
            if (Count == 0)
                return;

            if (2 * index > Count - 1)
                return;

            if (2 * index + 1 > Count - 1)
            {
                SwapIfSmaller(index, 2 * index, time);
                return;
            }

            var maxIndex = ((T)base[2 * index]).Compare((T)base[2 * index + 1], time)>0 ? 2 * index : 2 * index + 1;
            SwapIfSmaller(index, maxIndex, time);
        }

        public void SwapIfSmaller(int index1, int index2, int time)
        {
            if (((T)base[index1]).Compare((T)base[index2], time)<0)
            {
                var temp = base[index1];
                base[index1] = base[index2];
                base[index2] = temp;
                BubbleDown(index2, time);
            }
        }

        public void Push(T toPush, int time)
        {
            base.Insert(Count, toPush);
            BubbleUp(Count - 1, time);
        }

        private void BubbleUp(int index, int time)
        {
            if (index == 0)
                return;

            var parent = index / 2;
            if (((T)base[parent]).Compare((T)base[index], time) < 0)
            {
                var temp = base[index];
                base[index] = base[parent];
                base[parent] = temp;
                BubbleUp(parent, time);
            }
            BubbleDown(index, time);
        }

    }
}